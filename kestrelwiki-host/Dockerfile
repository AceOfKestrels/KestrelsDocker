# Use the official Microsoft .NET SDK image to build the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Install Git
# hadolint ignore=DL3015,DL3008
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# Clone the repository
RUN git clone https://github.com/AceOfKestrels/KestrelsWiki src

# Change working directory to the correct project directory
WORKDIR /app/src

# Restore dependencies with verbose logging
# hadolint ignore=DL3059
RUN dotnet restore --force-evaluate

# Build and publish the application
# hadolint ignore=DL3059
RUN dotnet publish kestrelswiki/kestrelswiki.csproj -c Release -o out
# Use the official ASP.NET runtime image for production
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# Copy the published files
COPY --from=build /app/src/out ./

# Expose the application port
EXPOSE 80

# Setup web ENVs
ENV ASPNETCORE_HTTP_PORTS=80 \
    CONTENT_PATH="../content" \
    WEBROOT_PATH="../wwwroot" \
    WEBPAGE_REPOSITORY="https://github.com/AceOfKestrels/kestrelsnest.git"

# Setup logging directory
RUN mkdir /var/log/kestrelswiki && chmod 777 -R /var/log/kestrelswiki

# Setup logging ENVs
ENV FILE_LOGGING=true \
    LOG_PATH="/var/log/kestrelswiki"

# Set the entry point
ENTRYPOINT ["dotnet", "kestrelswiki.dll"]