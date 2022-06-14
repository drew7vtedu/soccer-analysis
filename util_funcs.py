import yaml

def load_config(config_path) -> dict:
    """
    loads a file at the given path as a dictionary
    """
    with open(config_path, 'r') as file:
        return yaml.safe_load(file)

