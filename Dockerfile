# syntax=docker/dockerfile:1

FROM mcr.microsoft.com/dotnet/sdk:6.0 as build-env

WORKDIR /hello-world
COPY hello-world/*.csproj .
RUN dotnet restore
COPY hello-world .

RUN dotnet publish -c Release -o /publish

FROM mcr.microsoft.com/dotnet/aspnet:6.0 as runtime
WORKDIR /publish
COPY --from=build-env /publish .

ENTRYPOINT ["dotnet", "hello-world.dll"]
