{{/*
Expand the name of the chart.
*/}}
{{- define "backend.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "backend.fullname" -}}
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
{{- define "backend.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels for backend.
*/}}
{{- define "backend.labels" -}}
helm.sh/chart: {{ include "backend.chart" . }}
{{ include "backend.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels for backend.
*/}}
{{- define "backend.selectorLabels" -}}
app.kubernetes.io/name: {{ include "backend.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Validate HPA configuration.
*/}}
{{- define "backend.hpa.validate" -}}
{{- if and .Values.autoscaling.enabled (not .Values.autoscaling.minReplicas) }}
  {{- fail "autoscaling.minReplicas is required when autoscaling is enabled" }}
{{- end }}
{{- if and .Values.autoscaling.enabled (not .Values.autoscaling.maxReplicas) }}
  {{- fail "autoscaling.maxReplicas is required when autoscaling is enabled" }}
{{- end }}
{{- if and .Values.autoscaling.enabled (lt .Values.autoscaling.maxReplicas .Values.autoscaling.minReplicas) }}
  {{- fail "autoscaling.maxReplicas must be greater than or equal to autoscaling.minReplicas" }}
{{- end }}
{{- if and .Values.autoscaling.enabled (not .Values.autoscaling.targetCPUUtilizationPercentage) (not .Values.autoscaling.targetMemoryUtilizationPercentage) }}
  {{- fail "At least one of targetCPUUtilizationPercentage or targetMemoryUtilizationPercentage must be set" }}
{{- end }}
{{- end }}