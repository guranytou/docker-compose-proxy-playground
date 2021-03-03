terraform {
  required_version = "~> 0.14"

  required_providers {
    keycloak = {
      source  = "mrparkers/keycloak"
      version = "2.2.0"
    }
  }
}

provider "keycloak" {
  url       = "http://keycloak:8080"
  client_id = "admin-cli"
  username  = "admin"
  password  = "admin"
}

resource "keycloak_realm" "master" {
  realm = "master"
  enabled = true

  internationalization {
    supported_locales = [
      "ja",
      "en",
    ]
    default_locale = "ja"
  }
}

resource "keycloak_openid_client" "keycloak-bulk" {
  realm_id  = keycloak_realm.master.id
  client_id = "keycloak-bulk"
  client_secret = "80a00dd6-7419-44a1-864d-ac8e44ebf68e"

  name    = "keycloak-bulk"
  enabled = true

  access_type = "CONFIDENTIAL"
  standard_flow_enabled = true
  valid_redirect_uris = [
    "*"
  ]
  web_origins = [
    "*"
  ] 

  login_theme = "keycloak"
}