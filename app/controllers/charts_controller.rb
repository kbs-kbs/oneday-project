class ChartsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:generate]

  def index
  end

  def generate
    prompt = params[:prompt]

    if prompt.blank?
      render json: { error: 'Prompt is required' }, status: :bad_request
      return
    end

    begin
      mermaid_code = call_perplexity_api(prompt)
      render json: { mermaid_code: mermaid_code }
    rescue => e
      render json: { error: e.message }, status: :internal_server_error
    end
  end

  private

  def call_perplexity_api(user_prompt)
    api_key = ENV['PERPLEXITY_API_KEY']

    if api_key.blank?
      raise "PERPLEXITY_API_KEY environment variable is not set"
    end

    system_prompt = <<~PROMPT
      You are a Mermaid Architecture diagram expert.
      Your task is to generate a Mermaid 'architecture-beta' diagram using ONLY the official syntax (see: https://mermaid.js.org/syntax/architecture.html#icons).

      Please follow these rules strictly, in order:

      1. The output must start with architecture-beta, and contain ONLY valid Mermaid architecture-beta code.
      2. Do not include any explanations, comments, summaries, or markdown code blocks—only the raw diagram code.
      3. Use only the following group, service, and connection statements as described in the documentation and examples below.
      4. Do not use any special characters (such as spaces, &, /, or other symbols) in any group or service label. Use only English letters, numbers, and underscores.
      5. For all service icons, use only one of these: (cloud), (database), (disk), (internet), (server).
      6. For all service connections, use ONLY one of these four directions:
          - :R -- L:
          - :L -- R:
          - :T -- B:
          - :B -- T:
      7. Connections must be made strictly between services only, and group names must never appear in any connection statements.
      8. Do not use any other icons, direction styles, or syntax.

      Example (follow this pattern exactly):

      architecture-beta
          group render(cloud)[Render]
              service fastapi(server)[FastAPI] in render
              service sqlite(database)[SQLite] in render
          group netlify(internet)[Netlify]
              service frontend_react(internet)[React] in netlify
          sqlite:R -- L:fastapi
          frontend_react:R -- L:fastapi

      ---

      Now, based on the user's project description, generate the Mermaid diagram.
    PROMPT

    response = HTTParty.post(
      'https://api.perplexity.ai/chat/completions',
      headers: {
        'Authorization' => "Bearer #{api_key}",
        'Content-Type' => 'application/json'
      },
      body: {
        model: 'sonar',
        messages: [
          { role: 'system', content: system_prompt },
          { role: 'user', content: user_prompt }
        ]
      }.to_json
    )

    if response.code == 200
      content = response.dig('choices', 0, 'message', 'content')

      # Remove markdown code blocks if present
      puts "==== Perplexity content ===="
      puts content

      # architecture-beta로 시작하는 줄 이후 모두 포함하도록 파싱 완화
      arch_index = content =~ /^architecture-beta/i
      if arch_index
        code = content[arch_index..-1]
        # 각 줄이 mermaid architecture code 패턴이면 포함
        code = code.lines.select { |line|
          line =~ /^\s*(architecture-beta|group |service |[a-zA-Z0-9_\-]+:[TBLR]? ?-- ?[TBLR]?:[a-zA-Z0-9_\-]+)/
        }.join("\n").strip
        content = code
      end

      content
    else
      raise "API Error: #{response.code} - #{response.body}"
    end
  end
end
