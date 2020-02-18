FROM mcr.microsoft.com/dotnet/core/sdk:3.1-alpine as build-image

WORKDIR /home/app

COPY ./*.csproj ./

RUN dotnet restore

COPY . .

RUN dotnet publish . -o /publish/

FROM mcr.microsoft.com/dotnet/core/runtime:3.1-alpine

WORKDIR /publish

COPY --from=build-image /publish .

ENTRYPOINT ["dotnet", "docker-dotnet.dll"]
