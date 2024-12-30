from flask import Flask, request, jsonify
from flask_cors import CORS
import requests
import json

app = Flask(__name__)
CORS(app)

# Votre clé API
API_KEY = "YOUR_API_KEY"
API_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent"

# Produits prédéfinis
products = [
    {"id": 1, "name": "Iphone X "},
    {"id": 2, "name": "Iphone 11"},
    {"id": 3, "name": "Iphone 12"},
    {"id": 4, "name": "Iphone 13"},
    {"id": 5, "name": "Iphone 14"},
]

@app.route('/search', methods=['POST'])
def search():
    # Récupérer la requête de recherche depuis le frontend
    query = request.json.get('query', '')
    if not query:
        return jsonify({"error": "Ne peut pas etre vide"}), 400

    # Préparer les données pour l'API Gemini
    payload = {
        "contents": [
            {
                "parts": [{"text": f"Trouvez le produit qui correspond le mieux à: {query}. Produits: {products}"}]
            }
        ]
    }

    headers = {
        "Content-Type": "application/json"
    }

    # Effectuer la requête à l'API
    response = requests.post(f"https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=AIzaSyDUYaL0iHI8mbX8c8rGEdgBOX7aki2ctQY", headers=headers, data=json.dumps(payload))

    if response.status_code == 200:
        # Retourner la réponse de l'API au frontend
        result = response.json()
        return jsonify({"results": result})
    else:
        return jsonify({"error": response.text}), response.status_code

if __name__ == '__main__':
    app.run(debug=True)
