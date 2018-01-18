
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

#fonction Nokogiri qui permet de récuperer les informations de la page http dont on a besoin
page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))

# fonction n°1 qui récupère la liste d'url qui nous sert a alimenter la fonction N°2 
def get_all_the_urls_of_val_doise_townhalls(page)
	urls = []
	page.css('a.lientxt').each do |url|     	
     	url = url['href']
     	url.slice!(0)
     	url = "http://annuaire-des-mairies.com#{url}"
     	urls = urls.push(url)
      	end
     return urls
end 

# fonction n°2 qui recherche l'adresse mail des mairies.
def get_the_email_of_a_townhal_from_its_webpage(page2)
	page3 = Nokogiri::HTML(open(page2))
	adresse = page3.css('//tr[4] td.style27 p.Style22 font')[1]
		return adresse.text
end

# fonction n°3 qui génère la liste des villes qui nous servira a indexer les adresse mail dans le hash
def get_all_the_list_of_town(page)
		list_of_town = []
		page.css('a.lientxt').each do |town|
			town = town.text
			list_of_town = list_of_town.push(town)
		end
		return list_of_town
end


h = Hash.new 

# Appel des fonction n°1 et 3 de listage
listurl = get_all_the_urls_of_val_doise_townhalls(page)
listnom = get_all_the_list_of_town(page)


# boucle qui fait fonctionner la recherche d'adresse mail des mairies et qui l'incorpore dans le hash
count = 0
while count < listnom.length
	mail = get_the_email_of_a_townhal_from_its_webpage(listurl[count])
	h[listnom[count]] = mail
	count += 1
end

puts h


	









