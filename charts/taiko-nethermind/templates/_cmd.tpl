{{- define "taiko-nethermind.defaultCommand" -}}
{{- $renderedArray := list }}
{{- $argsMap := dict }}
{{- range $item := .Values.args }}
  {{- $parts := splitList "=" $item }}
  {{- $argsMap = set $argsMap (index $parts 0) (index $parts 1) }}
{{- end }}
{{- range $item := .Values.defaultCommandTemplate }}
  {{- $parts := splitList "=" $item }}
  {{- $flag := index $parts 0 }}
  {{- if hasKey $argsMap $flag }}
    {{- $renderedItem := printf "%s=%s" $flag (index $argsMap $flag) -}}
    {{- $renderedArray = append $renderedArray $renderedItem }}
  {{- else }}
    {{- $renderedItem := tpl $item $ -}}
    {{- $renderedArray = append $renderedArray $renderedItem }}
  {{- end }}
{{- end }}
{{- $defaultCommandTemplateFlags := dict }}
{{- range $item := .Values.defaultCommandTemplate }}
  {{- $parts := splitList "=" $item }}
  {{- $_ := set $defaultCommandTemplateFlags (index $parts 0) true }}
{{- end }}
{{- range $item := .Values.args }}
  {{- $parts := splitList "=" $item }}
  {{- $flag := index $parts 0 }}
  {{- if not (hasKey $defaultCommandTemplateFlags $flag) }}
    {{- $renderedItem := tpl $item $ -}}
    {{- $renderedArray = append $renderedArray $renderedItem }}
  {{- end }}
{{- end }}
{{- $commandString := join " " $renderedArray }}
{{- $commandString }}
{{- end }}
