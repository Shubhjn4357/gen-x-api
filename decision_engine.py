# decision_engine.py

from nlp_processor import generate_response_with_knowledge, classify_intent
from search_and_scrape import search_and_scrape
from knowledge_base import retrieve_knowledge, store_knowledge

class DecisionEngine:
    def __init__(self):
        # Initialize any state if needed
        pass
    
    def decide(self, prompt: str) -> str:
        # Classify the user's intent
        intent = classify_intent(prompt)
        
        # Handle different intents dynamically
        if intent == "query":
            # Retrieve knowledge from the database
            stored_knowledge = retrieve_knowledge(prompt)
            if stored_knowledge:
                return generate_response_with_knowledge(prompt, stored_knowledge)
            else:
                # Perform a web search and store the new knowledge
                print("AI: Searching the web for new information...")
                search_results = search_and_scrape(prompt)
                if search_results:
                    store_knowledge(prompt, ' '.join(search_results))
                    return generate_response_with_knowledge(prompt, ' '.join(search_results))
                else:
                    return "I couldn't find any information on this topic."
        
        elif intent == "task":
            # Handle specific tasks dynamically
            return self.handle_task(prompt)
        
        elif intent == "conversation":
            # Use a conversational model for open-ended dialogue
            return generate_response_with_knowledge(prompt, "")
        
        else:
            return "I'm not sure how to handle that request. Can you provide more details?"
    
    def handle_task(self, prompt: str) -> str:
        # Example of handling a specific task
        if "weather" in prompt:
            return "You asked about the weather. Let me get that information for you."
        elif "schedule" in prompt:
            return "You want to manage your schedule. I can assist with that."
        else:
            return "Task handling not implemented for this query."

# Example usage
if __name__ == "__main__":
    engine = DecisionEngine()
    print("AI: Hello! Ask me anything, and I will use my knowledge to answer or make decisions.")
    while True:
        user_input = input("You: ")
        response = engine.decide(user_input)
        print(f"AI: {response}")
