{{/*
        Defined methods using helm template to create common usage.
    */}}

{{/*
        logs the chart details.
    */}}



{{/* not used */}}

{{- define "documentServiceChartNameTrace" -}}
    {{- $chartName := default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
    {{- $chartVersion := default .Chart.Version .Values.versionOverride | trunc 63 | trimSuffix "-" }}
    {{- $appVersion := default .Chart.AppVersion .Values.appVersionOverride | trunc 63 | trimSuffix "-" }}

    {{- printf "%s-%s and the app version is %s"  $chartName $chartVersion $appVersion | trimSuffix "-" }}
{{- end}}

{{- define "document-service.chart.name" -}}
    {{- default .Chart.Name .Values.name | trunc 63 | trimSuffix "-"}}
{{end}}

{{- define "document-service.app.name" -}}
    {{- if .Values.name}}
        {{- .Values.name | trunc 63 | trimSuffix "-" }}
    {{- else}}
        {{printf "%s-%s" .Release.Name (include "document-service.chart.name" .) | trunc 63 | trimSuffix "-"}}
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

{{- define "document-app.podName" -}}
    {{- required "The pod name is not exist" (index .Values "document-app" "labels" "pod-name") }}
{{- end}}


{{- define "document-app.deployment.image.fullname" -}}
    {{- printf "%s/" (required "the image repository does not exist" (index .Values "document-app" "deployment" "image" "repository")) }}
    {{- printf "%s:" (required "the image repository does not exist" (index .Values "document-app" "deployment" "image" "image-name")) }}
    {{- printf "%s" (default "latest" (index .Values "document-app" "deployment" "image" "image-version") | trunc 63 | trimSuffix "-") }}

{{- end}}

{{/*
        in this section I will defined the label value by defult if not exist
        the label will be 
        1- owner
        2- env
        3- app
*/}}

{{- define "document-app.labels.owner" -}}
    {{- default "abdalrhman" (index .Values "document-app" "labels" "owner") }}
{{- end }}

{{- define "document-app.labels.env" -}}
    {{- default "dev" (index .Values "document-app" "labels" "env") }}
{{- end }}

{{- define "document-app.labels.app" -}}
    {{- default "document-app" (index .Values "document-app" "labels" "app") }}
{{- end }}

{{- define "document-app.labels" -}}
app.kubernetes.io/name: {{ include "document-service.chart.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
owner: {{ include "document-app.labels.owner" . }}
evn: {{ include "document-app.labels.env" . }}
app: {{include "document-app.labels.app" .}}
{{end}}