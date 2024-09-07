# knowledge_base.py

import sqlite3

# Initialize the SQLite database
def init_db():
    conn = sqlite3.connect('knowledge_base.db')
    cursor = conn.cursor()
    # Create table to store knowledge
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS knowledge (
            id INTEGER PRIMARY KEY,
            topic TEXT,
            content TEXT
        )
    ''')
    conn.commit()
    conn.close()

# Store new knowledge in the database
def store_knowledge(topic, content):
    conn = sqlite3.connect('knowledge_base.db')
    cursor = conn.cursor()
    cursor.execute('INSERT INTO knowledge (topic, content) VALUES (?, ?)', (topic, content))
    conn.commit()
    conn.close()

# Retrieve knowledge from the database
def retrieve_knowledge(topic):
    conn = sqlite3.connect('knowledge_base.db')
    cursor = conn.cursor()
    cursor.execute('SELECT content FROM knowledge WHERE topic = ?', (topic,))
    rows = cursor.fetchall()
    conn.close()
    return [row[0] for row in rows]  # Return list of stored knowledge content

# Initialize the database
init_db()
