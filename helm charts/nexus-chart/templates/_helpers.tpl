{{/*
        Defined methods using helm template to create common usage.
        Author: Abdalrhman Alkrain
        Year: 2025
        Version: 1.0
*/}}

{{/*
        logs the chart details.
    */}}



{{/* not used */}}

{{- define "nexusChartNameTrace" -}}
    {{- $chartName := default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
    {{- $chartVersion := default .Chart.Version .Values.versionOverride | trunc 63 | trimSuffix "-" }}
    {{- $appVersion := default .Chart.AppVersion .Values.appVersionOverride | trunc 63 | trimSuffix "-" }}

    {{- printf "%s-%s and the app version is %s"  $chartName $chartVersion $appVersion | trimSuffix "-" }}
{{- end}}

{{- define "getChartName" -}}
    {{- default .Chart.Name .Values.name | trunc 63 | trimSuffix "-" }}
{{end}}

{{- define "app.name" -}}
    {{- if .Values.name}}
        {{- .Values.name | trunc 63 | trimSuffix "-" }}
    {{- else}}
        {{printf "%s-%s" .Release.Name (include "getChartName" .) | trunc 63 | trimSuffix "-" }}
    {{- end }}
{{end}}


{{/*
    TODO: I will check if the name space is not defined to print warrning for trace.
*/}}

{{/*
        Write the code here 
        // My code
    
*/}}

{{/*
        I will do some validation of the image 
        1- repo
        2- name
        3- version
        4- pod name

        and after that i will print the result to verify all of these.
*/}}

# {{- define "document-db.podName" -}}
#     {{- required "The pod name is not exist" (index .Values "document-db" "labels" "pod-name") }}
# {{- end}}


{{- define "nexus.deployment.image.fullname" -}}
    {{- printf "%s/" (required "the image repository does not exist" (index .Values.nexus.deployment.image.repository)) }}
    {{- printf "%s:" (required "the image repository does not exist" (index .Values.nexus.deployment.image "image-name")) }}
    {{- printf "%s" (default "latest" (index .Values.nexus.deployment.image "image-version") | trunc 63 | trimSuffix "-") }}
{{- end}}

{{/*
        in this section I will defined the label value by defult if not exist
        the label will be 
        1- owner
        2- env
        3- app
*/}}


{{- define "common.labels.owner" -}}
    {{- default "abdalrhman" (index .Values.common.labels.owner) }}
{{- end }}

{{- define "common.labels.env" -}}
    {{- default "dev" (index .Values.common.labels.env) }}
{{- end }}

{{- define "common.labels.app" -}}
    {{- default "nexus" (index .Values.common.labels.app) }}
{{- end }}

{{- define "common.labels" -}}
app.kubernetes.io/name: {{ include "getChartName" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
owner: {{ include "common.labels.owner" . }}
evn: {{ include "common.labels.env" . }}
app: {{include "common.labels.app" .}}
{{end}}
