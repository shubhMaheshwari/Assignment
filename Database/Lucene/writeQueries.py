from urllib2 import *
import simplejson

#default query //uses superset of lucene query syntax
general = 'http://localhost:8983/solr/films/select?q=*:*'
default = 'http://localhost:8983/solr/films/select?q=*:*'
boolean = 'http://localhost:8983/solr/films/select?q=*:*'


connection = urlopen(boolean)
response = simplejson.load(connection)



#print response
print response['response']['numFound'], "documents found."

# Print the name of each document.
for document in response['response']['docs']:
    #print "resourcename: =", document['resourcename']
    print "id: =", document['id']
    #print '\n'
#    print "  directed_by =", document['directed_by']
#    print "  genre =", document['genre']
