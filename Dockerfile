# Usa Debian como imagen base
FROM debian:latest

# Instala dependencias
RUN apt-get update && apt-get install -y \
    curl \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Instala elm y elm-live
RUN npm install -g elm elm-live

# Crea un directorio de trabajo
WORKDIR /app

# Expone el puerto en el que correrá elm-live
EXPOSE 8000

# Comando por defecto para iniciar elm-live en modo watch
CMD ["elm-live", "src/Main.elm", "--open", "--start-page=build/index.html", "--host=0.0.0.0", "--", "--output=build/main.js" ]
#CMD ["sh", "-c", "tail -f /dev/null"]