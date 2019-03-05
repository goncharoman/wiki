import requests, os
import urllib.parse as up
from sys import argv
import configparser


config = configparser.ConfigParser()
config.read(os.path.join(os.environ["HOME"], ".wiki", "config"))
locale = config["default"]["locale"]

def main(users_query, *options):
	# wiki api
	host = 'https://{}.wikipedia.org/w/api.php?'.format(locale)
	# actions
	search = '&'.join([
						'action=opensearch',
						'search={}'.format(up.quote(users_query)),
						'prop=info',
						'format=json',
						'inprop=url'
						])
	# full url
	url = host + search
	# request
	responce = requests.get(url)
	if (responce.status_code != requests.codes.ok):
		print("Bad request (status code {})".format(responce.status_code))
		exit

	for ans in responce.json()[2]:
		print(ans)

if __name__ == "__main__":
	main(argv[1])
