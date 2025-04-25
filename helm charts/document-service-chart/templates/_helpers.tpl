{{
    /*
        Defined methods using helm template to create common usage.
    */
}}

{{
    /*
        logs the chart details.
    */
}}




{{- define "document-service-chart.name" - }}
    {{- $chartName := default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-"}}
    {{- $chartVersion := default .Chart.Version .Values.versionOverride | trunc 63 | trimSuffix "-"}}
    {{- $appVersion := default .Chart.AppVersion .Values.appVersionOverride | trunc 63 | trimSuffix "-"}}

    {{- printf "%s-%s and the app version is %s"  $chartName $chartVersion $appVersion | trimSuffix "-" }}
{{- end}}

{{
    /*
        I will do some validation of the image 
        1- repo
        2- name
        3- version
        4- pod name

        and after that i will print the result to verify all of these.
    */
}}

{{-define "document-service-app.podName"-}}
    {{ - required "The pod name is not exist" .Values.document-app.labels."pod-name"}}
    {{- printf "the pod name is %s" .Values.document-app.labels."pod-name" | trimSuffix "-" }}

{{- end}}

{{define "document-app.deployment.image.fullname"}}
    {{- required "the image repository does not exist" .Values.document-app.deployment.image.repository}}
    {{- required "the image repository does not exist" .Values.document-app.deployment.image."image-name"}}
    {{- $imageVersion := default "latest" .Values.document-app.deployment.image."image-version" | trunc 63 | trimSuffix "-" }}
    
    {{- $fullImageName := .Values.document-app.deployment.image.repository + "/" + .Values.document-app.deployment.image."image-name" + ":" + $imageVersion}}
    {{- $fullImageName := printf "%s/%s:%s" .Values.document-app.deployment.image.repository .Values.document-app.deployment.image."image-name" $imageVersion }}
    {{- printf "%s" $fullImageName }}
{{- end}}

{{
    /*
        in this section I will defined the label value by defult if not exist
        the label will be 
        1- owner
        2- env
        3- app
    */
}}

{{- define "document-app.labels.owner" -}}
    {{- default "abdalrhman" .Values.document-app.labels.owner}}
{{- end }}

{{- define "document-app.labels.env" -}}
    {{- default "dev" .Values.document-app.labels.env}}
{{- end }}

{{- define "document-app.labels.app" -}}
    {{- default "document-app" .Values.document-app.labels.app}}
{{- end }}


# {{/*
# Expand the name of the chart.
# */}}
# {{- define "document-service-chart.name" -}}
# {{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
# {{- end }}

# {{/*
# Create a default fully qualified app name.
# We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
# If release name contains chart name it will be used as a full name.
# */}}
# {{- define "document-service-chart.fullname" -}}
# {{- if .Values.fullnameOverride }}
# {{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
# {{- else }}
# {{- $name := default .Chart.Name .Values.nameOverride }}
# {{- if contains $name .Release.Name }}
# {{- .Release.Name | trunc 63 | trimSuffix "-" }}
# {{- else }}
# {{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
# {{- end }}
# {{- end }}
# {{- end }}

# {{/*
# Create chart name and version as used by the chart label.
# */}}
# {{- define "document-service-chart.chart" -}}
# {{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
# {{- end }}

# {{/*
# Common labels
# */}}
# {{- define "document-service-chart.labels" -}}
# helm.sh/chart: {{ include "document-service-chart.chart" . }}
# {{ include "document-service-chart.selectorLabels" . }}
# {{- if .Chart.AppVersion }}
# app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
# {{- end }}
# app.kubernetes.io/managed-by: {{ .Release.Service }}
# {{- end }}

# {{/*
# Selector labels
# */}}
# {{- define "document-service-chart.selectorLabels" -}}
# app.kubernetes.io/name: {{ include "document-service-chart.name" . }}
# app.kubernetes.io/instance: {{ .Release.Name }}
# {{- end }}

# {{/*
# Create the name of the service account to use
# */}}
# {{- define "document-service-chart.serviceAccountName" -}}
# {{- if .Values.serviceAccount.create }}
# {{- default (include "document-service-chart.fullname" .) .Values.serviceAccount.name }}
# {{- else }}
# {{- default "default" .Values.serviceAccount.name }}
# {{- end }}
# {{- end }}
