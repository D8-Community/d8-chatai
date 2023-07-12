# D8 Chat AI

**D8 Chat AI**  is an advanced artificial intelligence chatbot designed to provide engaging and interactive conversations with users. It is built with state-of-the-art natural language processing and machine learning techniques, enabling it to understand and respond to user queries in a human-like manner.

## Features

1.  **Conversation Generation:**  D8 Chat AI can generate dynamic and context-aware conversations with users. It keeps track of the conversation history, allowing for continuity and a more personalized experience.
    
2.  **Natural Language Understanding:**  The AI has been trained on vast amounts of text data, enabling it to understand and interpret user queries accurately. It can comprehend complex sentences, idiomatic expressions, and even contextual nuances to provide relevant responses.
    
3.  **Intelligent Responses:**  D8 Chat AI goes beyond simple keyword matching. It utilizes machine learning algorithms to generate insightful and coherent responses. It can provide recommendations, answer factual questions, engage in discussions, and even offer creative suggestions.
    
4.  **Adaptability:**  D8 Chat AI continually learns and improves from user interactions. It adapts to different conversational styles, preferences, and languages. The more it interacts with users, the better it becomes at tailoring responses to individual needs.
    
5.  **Multi-Platform Support:**  The chatbot is available on various platforms, including web browsers, mobile apps, and social media platforms. It seamlessly integrates into existing applications and services, enhancing user experiences across different channels.
    
6.  **Privacy and Security:**  D8 Chat AI prioritizes user privacy and data security. It employs encryption to protect sensitive user information and adheres to strict data protection protocols. User interactions are anonymized and confidential, ensuring that personal information remains secure.
    

## Use Cases

-   **Customer Support:**  D8 Chat AI can handle customer queries, provide instant responses, and assist with common support issues. It can reduce wait times, offer troubleshooting guidance, and escalate complex cases to human agents when necessary.
    
-   **Virtual Assistant:**  The AI can act as a personal virtual assistant, helping with tasks such as scheduling appointments, setting reminders, providing weather updates, and answering general knowledge questions.
    
-   **Content Recommendation:**  D8 Chat AI can suggest personalized content based on user preferences, including articles, videos, music, or product recommendations. It learns from user interactions and adapts recommendations accordingly.
    
-   **Language Learning:**  The chatbot can assist users in learning new languages by engaging in conversations, providing vocabulary definitions, practicing grammar rules, and offering pronunciation tips.
    
-   **Entertainment and Engagement:**  D8 Chat AI can engage users in entertaining and thought-provoking conversations, tell jokes, share fun facts, play trivia quizzes, or even simulate role-playing games.
    

D8 Chat AI is an intelligent and versatile conversational AI tool that aims to enhance user interactions across a wide range of applications. Its advanced capabilities in understanding context, generating intelligent responses, and adaptability make it a valuable and engaging chatbot for numerous use cases.
**Docker**

Build locally:

```shell
docker build -t meetlily/d8-chatai:latest .
docker run -e OPENAI_API_KEY=xxx -p 3000:3000 meetlily/d8-chatai:latest
```

Pull from github(ghcr):

```
docker run -e OPENAI_API_KEY=xxx -p 3000:3000 ghcr.io/mckaywrigley/chatbot-ui:main
```

## Running Locally

**1. Clone Repo**

```bash
git clone https://github.com/edvillan15/d8-chatai.git
```

**2. Install Dependencies**

```bash
npm i
```

**3. Provide OpenAI API Key**

Create a .env.local file in the root of the repo with your OpenAI API Key:

```bash
OPENAI_API_KEY=YOUR_KEY
```

> You can set `OPENAI_API_HOST` where access to the official OpenAI host is restricted or unavailable, allowing users to configure an alternative host for their specific needs.

> Additionally, if you have multiple OpenAI Organizations, you can set `OPENAI_ORGANIZATION` to specify one.

**4. Run App**

```bash
npm run dev
```

**5. Use It**

You should be able to start chatting.

## Configuration

When deploying the application, the following environment variables can be set:

| Environment Variable              | Default value                  | Description                                                                                                                               |
| --------------------------------- | ------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------- |
| OPENAI_API_KEY                    |                                | The default API key used for authentication with OpenAI                                                                                   |
| OPENAI_API_HOST                   | `https://api.openai.com`       | The base url, for Azure use `https://<endpoint>.openai.azure.com`                                                                         |
| OPENAI_API_TYPE                   | `openai`                       | The API type, options are `openai` or `azure`                                                                                             |
| OPENAI_API_VERSION                | `2023-03-15-preview`           | Only applicable for Azure OpenAI                                                                                                          |
| AZURE_DEPLOYMENT_ID               |                                | Needed when Azure OpenAI, Ref [Azure OpenAI API](https://learn.microsoft.com/zh-cn/azure/cognitive-services/openai/reference#completions) |
| OPENAI_ORGANIZATION               |                                | Your OpenAI organization ID                                                                                                               |
| DEFAULT_MODEL                     | `gpt-3.5-turbo`                | The default model to use on new conversations, for Azure use `gpt-35-turbo`                                                               |
| NEXT_PUBLIC_DEFAULT_SYSTEM_PROMPT | [see here](utils/app/const.ts) | The default system prompt to use on new conversations                                                                                     |
| NEXT_PUBLIC_DEFAULT_TEMPERATURE   | 1                              | The default temperature to use on new conversations                                                                                       |
| GOOGLE_API_KEY                    |                                | See [Custom Search JSON API documentation][GCSE]                                                                                          |
| GOOGLE_CSE_ID                     |                                | See [Custom Search JSON API documentation][GCSE]                                                                                          |

If you do not provide an OpenAI API key with `OPENAI_API_KEY`, users will have to provide their own key.

If you don't have an OpenAI API key, you can get one [here](https://platform.openai.com/account/api-keys).
