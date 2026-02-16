# Deploy Railway – Mercaro

Acest folder conține configurația pentru deploy pe Railway.

- **railway.json** – builder Dockerfile, restart policy
- **.env.production** – template variabile de mediu (nu conține secrete)
- **Dockerfile** – copie identică cu cel din rădăcină

**Dacă Railway dă „Dockerfile does not exist”:** în Variables adaugă  
`RAILWAY_DOCKERFILE_PATH` = `railway/Dockerfile`  
apoi Redeploy.

Ghid complet: vezi **RAILWAY-DEPLOY.md** în rădăcina proiectului.
