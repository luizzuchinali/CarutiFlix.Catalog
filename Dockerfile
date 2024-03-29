FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
EXPOSE 80

ARG CONFIGURATION=Debug

COPY "src/CarutiFlix.Catalog.Api/CarutiFlix.Catalog.Api.csproj" "src/CarutiFlix.Catalog.Api/CarutiFlix.Catalog.Api.csproj"
COPY "src/CarutiFlix.Catalog.Application/CarutiFlix.Catalog.Application.csproj" "src/CarutiFlix.Catalog.Application/CarutiFlix.Catalog.Application.csproj"
COPY "src/CarutiFlix.Catalog.Domain/CarutiFlix.Catalog.Domain.csproj" "src/CarutiFlix.Catalog.Domain/CarutiFlix.Catalog.Domain.csproj"
COPY "src/CarutiFlix.Catalog.Infra/CarutiFlix.Catalog.Infra.csproj" "src/CarutiFlix.Catalog.Infra/CarutiFlix.Catalog.Infra.csproj"

RUN dotnet restore src/CarutiFlix.Catalog.Api/CarutiFlix.Catalog.Api.csproj

COPY . ./
RUN dotnet publish -c $CONFIGURATION -o out

FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build-env /out .
ENTRYPOINT ["dotnet", "CarutiFlix.Catalog.Api.dll"]