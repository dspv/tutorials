# Create a new Python enviroment to isolate it
python -m venv env
source env/bin/activate

# install flask
pip install flask

pip freeze > requirements.txt