{{/*
Expand the name of the chart.
*/}}
{{- define "travel-site.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "travel-site.fullname" -}}
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
{{- define "travel-site.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "travel-site.labels" -}}
helm.sh/chart: {{ include "travel-site.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/part-of: {{ include "travel-site.name" . }}
{{- end }}

{{/*
Frontend labels
*/}}
{{- define "travel-site.frontend.labels" -}}
{{ include "travel-site.labels" . }}
app.kubernetes.io/name: {{ include "travel-site.name" . }}-frontend
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: frontend
app.kubernetes.io/version: {{ .Values.frontend.image.tag | default .Chart.AppVersion | quote }}
{{- end }}

{{/*
Frontend selector labels
*/}}
{{- define "travel-site.frontend.selectorLabels" -}}
app.kubernetes.io/name: {{ include "travel-site.name" . }}-frontend
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Backend labels
*/}}
{{- define "travel-site.backend.labels" -}}
{{ include "travel-site.labels" . }}
app.kubernetes.io/name: {{ include "travel-site.name" . }}-backend
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: backend
app.kubernetes.io/version: {{ .Values.backend.image.tag | default .Chart.AppVersion | quote }}
{{- end }}

{{/*
Backend selector labels
*/}}
{{- define "travel-site.backend.selectorLabels" -}}
app.kubernetes.io/name: {{ include "travel-site.name" . }}-backend
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use.
*/}}
{{- define "travel-site.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "travel-site.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
