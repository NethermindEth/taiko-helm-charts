{{- define "taiko-nethermind.defaultCommand" -}}
{{- $renderedArray := list }}
{{- range $item := .Values.defaultCommandTemplate }}
  {{- $renderedItem := tpl $item $ -}}
  {{- $renderedArray = append $renderedArray $renderedItem }}
{{- end }}
{{- range $item := .Values.args }}
  {{- $renderedItem := tpl $item $ -}}
  {{- $renderedArray = append $renderedArray $renderedItem }}
{{- end }}
{{- $commandString := join " " $renderedArray }}
{{- $commandString }}
{{- end }}
