{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "pipelinesCrds.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "pipelinesCrds.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "pipelinesCrds.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create version.
*/}}
{{- define "pipelinesCrds.version" -}}
{{ default .Chart.AppVersion .Values.version }}
{{- end -}}

{{/*
Create webhook image.
*/}}
{{- define "pipelinesCrds.webhookImage" -}}
{{ printf "%s:%s" .Values.webhook.image.repository (default .Chart.AppVersion .Values.webhook.image.tag) }}
{{- end -}}

{{/*
Create the name of the service account to use for webhook
*/}}
{{- define "pipelinesCrds.webhookServiceAccount" -}}
{{- if .Values.rbac.create -}}
{{- template "pipelinesCrds.fullname" . -}}-webhook
{{- else -}}
{{- required "A service account name is required" .Values.rbac.webhookServiceAccount -}}
{{- end -}}
{{- end -}}

{{/*
Create base labels
*/}}
{{- define "pipelinesCrds.baseLabels" -}}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/part-of: tekton-pipelines-crds
{{- end -}}

{{/*
Create helm labels
*/}}
{{- define "pipelinesCrds.helmLabels" -}}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ template "pipelinesCrds.chart" . }}
{{- end -}}

{{/*
Create version labels
*/}}
{{- define "pipelinesCrds.versionLabels" -}}
app.kubernetes.io/version: {{ template "pipelinesCrds.version" . }}
pipeline.tekton.dev/release: {{ template "pipelinesCrds.version" . }}
version: {{ template "pipelinesCrds.version" . }}
{{- end -}}

{{/*
Create component labels
*/}}
{{- define "pipelinesCrds.componentLabels" -}}
app.kubernetes.io/component: {{ . }}
{{- end -}}

{{/*
Create name labels
*/}}
{{- define "pipelinesCrds.nameLabels" -}}
app.kubernetes.io/name: {{ . }}
{{- end -}}
