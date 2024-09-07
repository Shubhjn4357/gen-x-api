# app.py
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from decision_engine import DecisionEngine  # Import the decision engine from your previous code

app = FastAPI()
engine = DecisionEngine()  # Initialize the DecisionEngine

# Define request and response models
class QueryRequest(BaseModel):
    query: str

class QueryResponse(BaseModel):
    response: str

@app.post("/query", response_model=QueryResponse)
def query_ai(request: QueryRequest):
    try:
        user_query = request.query
        # Get AI's response using the DecisionEngine
        response = engine.decide(user_query)
        return {"response": response}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

# Start the server
if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
