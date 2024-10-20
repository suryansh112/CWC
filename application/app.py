from flask import Flask, render_template, request

app = Flask(__name__)

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/submit', methods=['POST'])
def submit():
    name = request.form.get('name')
    if not name:
        return render_template('result.html', message="Name cannot be empty", success=False)
    return render_template('result.html', message=f"Hello, {name}!", success=True)

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)
