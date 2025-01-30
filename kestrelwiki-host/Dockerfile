# Use the official Microsoft .NET SDK image to build the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Install Git
# hadolint ignore=DL3015,DL3008
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*


# Clone the repository
# hadolint ignore=DL3059
RUN git clone https://github.com/AceOfKestrels/KestrelsWiki src

# Change working directory to the source
WORKDIR /app/src

# Restore dependencies
# hadolint ignore=DL3059
RUN dotnet restore

# Build and publish the application
# hadolint ignore=DL3059
RUN dotnet publish -c Release -o out

# Use the official ASP.NET runtime image for production
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# get Program files
COPY --from=build /app/src/out ./

# Expose the port the application runs on
EXPOSE 80

# Setup web  ENVs
ENV ASPNETCORE_HTTP_PORTS   =   80 \
    CONTENT_PATH    =   "../content" \
    WEBROOT_PATH    =   "../wwwroot" \
    WEBPAGE_REPOSITORY  =   "https://github.com/AceOfKestrels/kestrelsnest.git" \
    
    
#setup logging flder
RUN mkdir /var/log/kestrelswiki && chmod 777 -R /var/log/kestrelswiki
#setup logging ENVs
ENV FILE_LOGGING    =   true \
    LOG_PATH    =   "/var/log/kestrelswiki"
    

    
    
# Set the entry point for the container
ENTRYPOINT ["dotnet", "kestrelswiki.dll"]
