# --- Étape 1 : construire le site avec Astro ---
FROM node:24-alpine AS build
WORKDIR /app

# Reçus depuis l'extérieur (GitHub Actions, ou --build-arg en local) :
# nécessaires ICI, car Astro lit process.env pendant "npm run build"
# (le site est statique, ces valeurs sont figées dans le HTML généré)
ARG GIT_COMMIT=local
ARG BUILD_DATE=unknown
ENV GIT_COMMIT=$GIT_COMMIT
ENV BUILD_DATE=$BUILD_DATE

# Copier uniquement les fichiers de dépendances d'abord : Docker met en
# cache cette étape et ne la refait pas tant que package.json ne change
# pas, même si tu modifies ton code juste après (accélère les builds)
COPY package.json package-lock.json ./
RUN npm ci

# Puis copier le reste du code et construire
COPY . .
RUN npm run build
# Résultat : le dossier /app/dist contient uniquement du HTML/CSS/JS statique

# --- Étape 2 : servir ce résultat avec nginx ---
# "nginx-unprivileged" : une variante d'nginx pensée pour tourner sans
# les droits root (port 8080 au lieu de 80) — cohérent avec le principe
# "non-root partout" qu'on a posé dès le début du projet
FROM nginxinc/nginx-unprivileged:1.27-alpine
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 8080
