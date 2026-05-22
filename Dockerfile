FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

COPY ["Microservicios.Atracciones.Identify.API/Microservicios.Atracciones.Identify.API.csproj", "Microservicios.Atracciones.Identify.API/"]
COPY ["Microservicios.Atracciones.Identify.Business/Microservicios.Atracciones.Identify.Business.csproj", "Microservicios.Atracciones.Identify.Business/"]
COPY ["Microservicios.Atracciones.Identify.DataAccess/Microservicios.Atracciones.Identify.DataAccess.csproj", "Microservicios.Atracciones.Identify.DataAccess/"]
COPY ["Microservicios.Atracciones.Identify.DataManagement/Microservicios.Atracciones.Identify.DataManagement.csproj", "Microservicios.Atracciones.Identify.DataManagement/"]

RUN dotnet restore "Microservicios.Atracciones.Identify.API/Microservicios.Atracciones.Identify.API.csproj"

COPY . .
WORKDIR "/src/Microservicios.Atracciones.Identify.API"
RUN dotnet publish -c Release -o /app/publish --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080
ENTRYPOINT ["dotnet", "Microservicios.Atracciones.Identify.API.dll"]
