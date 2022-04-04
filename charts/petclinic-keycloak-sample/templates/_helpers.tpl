{{/*
Expand the name of the chart.
*/}}
{{- define "petclinic-keycloak-sample.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "petclinic-keycloak-sample.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "petclinic-keycloak-sample.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "petclinic-keycloak-sample.labels" -}}
helm.sh/chart: {{ include "petclinic-keycloak-sample.chart" . }}
{{ include "petclinic-keycloak-sample.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "petclinic-keycloak-sample.selectorLabels" -}}
app.kubernetes.io/name: {{ include "petclinic-keycloak-sample.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "petclinic-keycloak-sample.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "petclinic-keycloak-sample.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{/*
Create the name of the service account to use
*/}}
{{- define "petclinic-keycloak-sample.realmconfig.configMap.name" -}}
{{- printf "%s-%s" (include "petclinic-keycloak-sample.fullname" .) .Values.realm.configMap.name }}
{{- end }}