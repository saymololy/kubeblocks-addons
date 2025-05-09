{{/*
Expand the name of the chart.
*/}}
{{- define "weaviate.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "weaviate.fullname" -}}
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
{{- define "weaviate.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "weaviate.labels" -}}
helm.sh/chart: {{ include "weaviate.chart" . }}
{{ include "weaviate.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "weaviate.selectorLabels" -}}
app.kubernetes.io/name: {{ include "weaviate.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common weaviate annotations
*/}}
{{- define "weaviate.annotations" -}}
{{ include "kblib.helm.resourcePolicy" . }}
{{ include "weaviate.apiVersion" . }}
{{- end }}

{{/*
API version annotation
*/}}
{{- define "weaviate.apiVersion" -}}
kubeblocks.io/crd-api-version: apps.kubeblocks.io/v1
{{- end }}

{{/*
Define weaviate component definition name
*/}}
{{- define "weaviate.componentDefName" -}}
weaviate-{{ .Chart.Version }}
{{- end -}}

{{/*
Define weaviate component definition regex pattern name
*/}}
{{- define "weaviate.cmpdRegexpPattern" -}}
^weaviate-
{{- end -}}

{{/*
Define weaviate config template name
*/}}
{{- define "weaviate.configTplName" -}}
weaviate-config-template
{{- end -}}

{{/*
Define weaviate env config template name
*/}}
{{- define "weaviate.envConfigTplName" -}}
weaviate-env-config-template
{{- end -}}

{{/*
Define weaviate env config constraint name
*/}}
{{- define "weaviate.pdName" -}}
weaviate-env-pd
{{- end -}}

{{/*
Define weaviate env config constraint name
*/}}
{{- define "weaviate.pcrName" -}}
weaviate-pcr
{{- end -}}

{{/*
Define image
*/}}
{{- define "weaviate.image" -}}
{{ .Values.images.registry | default "docker.io" }}/{{ .Values.images.repository }}:{{ .Values.images.tag | default "latest" }}
{{- end }}
