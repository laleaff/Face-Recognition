from deepface import DeepFace
from datetime import date
from flask import Flask, jsonify, request
from io import StringIO
import json

app = Flask(__name__)

@app.route('/absen', methods=['POST'])
def absen():
    params = request.get_json()
    result = DeepFace.find(img_path = "assets/absen/"+params['image1'], db_path = "assets/upload/siswa")
    # result_dict = result.to_dict(orient='records')
    # return jsonify(result_dict), 200
    # return jsonify(result), 200

    result_list_of_dicts = [df.to_dict(orient='records') for df in result]
    return jsonify(result_list_of_dicts), 200

if __name__ == '__main__':
    app.run(host="localhost", port=4000, debug=False)
