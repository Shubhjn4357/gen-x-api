# nlp_processor.py

from transformers import pipeline

# Load pre-trained models
chatbot = pipeline('text-generation', model='gpt2', max_length=100)

def generate_response_with_knowledge(prompt, context=""):
    """Generate a response using a pre-trained model and stored knowledge."""
    if context:
        response = chatbot(f"{prompt}\n\n{context}", max_length=150)
    else:
        response = chatbot(prompt, max_length=150)
    return response[0]['generated_text']

def classify_intent(prompt: str) -> str:
    """Classify the intent of the user's input."""
    # Simple example - in practice, this could use an ML model like BERT for classification
    if "how" in prompt or "what" in prompt:
        return "query"
    elif "schedule" in prompt or "reminder" in prompt:
        return "task"
    else:
        return "conversation"
