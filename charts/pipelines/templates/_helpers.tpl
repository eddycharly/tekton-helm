{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "pipelines.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "pipelines.fullname" -}}
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
{{- define "pipelines.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create version.
*/}}
{{- define "pipelines.version" -}}
{{ default .Chart.AppVersion .Values.version }}
{{- end -}}

{{/*
Create controller image.
*/}}
{{- define "pipelines.controllerImage" -}}
{{ printf "%s:%s" .Values.controller.image.repository (default .Chart.AppVersion .Values.controller.image.tag) }}
{{- end -}}

{{/*
Create webhook image.
*/}}
{{- define "pipelines.webhookImage" -}}
{{ printf "%s:%s" .Values.webhook.image.repository (default .Chart.AppVersion .Values.webhook.image.tag) }}
{{- end -}}

{{/*
Create the name of the service account to use for controller
*/}}
{{- define "pipelines.controllerServiceAccount" -}}
{{- if .Values.rbac.create -}}
{{- template "pipelines.fullname" . -}}
{{- else -}}
{{- required "A service account name is required" .Values.rbac.controllerServiceAccount -}}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use for webhook
*/}}
{{- define "pipelines.webhookServiceAccount" -}}
{{- if .Values.rbac.create -}}
{{- template "pipelines.fullname" . -}}-webhook
{{- else -}}
{{- required "A service account name is required" .Values.rbac.webhookServiceAccount -}}
{{- end -}}
{{- end -}}

{{/*
Create base labels
*/}}
{{- define "pipelines.baseLabels" -}}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/part-of: tekton-pipelines
{{- end -}}

{{/*
Create helm labels
*/}}
{{- define "pipelines.helmLabels" -}}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ template "pipelines.chart" . }}
{{- end -}}

{{/*
Create version labels
*/}}
{{- define "pipelines.versionLabels" -}}
app.kubernetes.io/version: {{ template "pipelines.version" . }}
pipeline.tekton.dev/release: {{ template "pipelines.version" . }}
version: {{ template "pipelines.version" . }}
{{- end -}}

{{/*
Create component labels
*/}}
{{- define "pipelines.componentLabels" -}}
app.kubernetes.io/component: {{ . }}
{{- end -}}

{{/*
Create name labels
*/}}
{{- define "pipelines.nameLabels" -}}
app.kubernetes.io/name: {{ . }}
{{- end -}}
