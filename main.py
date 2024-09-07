# main.py

from decision_engine import DecisionEngine

def main():
    engine = DecisionEngine()
    print("AI: Hello! Ask me anything, and I will use my knowledge to answer or make decisions.")
    while True:
        user_input = input("You: ")
        response = engine.decide(user_input)
        print(f"AI: {response}")

if __name__ == "__main__":
    main()
