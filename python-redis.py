import redis

r = redis.Redis(host='172.17.0.1',port=6379)
r.set('lenguaje', 'python')
print(r.get('lenguaje'))

number = ["cero","uno","dos","tres"]

for i in range(len(number)):
    r.hset("numero", number[i], str(i))

print(r.hgetall("numero"))
