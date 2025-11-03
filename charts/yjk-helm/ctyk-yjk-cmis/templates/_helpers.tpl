{{/*
Expand the name of the chart.
*/}}
{{- define "ctyk-yjk.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ctyk-yjk.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- $fullname := default (ternary .Release.Name (printf "%s-%s" $name .Release.Name) (contains $name .Release.Name)) .Values.fullnameOverride }}
{{- $fullname | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "ctyk-yjk.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ctyk-yjk.labels" -}}
helm.sh/chart: {{ include "ctyk-yjk.chart" . }}
{{ include "ctyk-yjk.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "ctyk-yjk.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ctyk-yjk.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Return the proper image Registry Secret Names
*/}}
{{- define "ctyk-yjk.imagePullSecrets" -}}
{{ include "common.images.pullSecrets" (dict "images" (list .Values.image) "global" .Values.global) }}
{{- end -}}


{{/*
Return the proper image name
*/}}
{{- define "ctyk-yjk.image" -}}
{{- $image := .Values.image -}}
{{- $tag := default .Chart.AppVersion $image.tag -}}
{{- $_ := set $image "tag" $tag -}}
{{ include "common.images.image" (dict "imageRoot" $_ "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper image name
*/}}
{{- define "test.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.testImage "global" .Values.global) }}
{{- end -}}