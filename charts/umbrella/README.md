umbrella
========
This chart bootstraps installation of Tekton components:
- [tekton pipeline](https://github.com/tektoncd/pipeline)
- [tekton triggers](https://github.com/tektoncd/triggers)
- [tekton dashboard](https://github.com/tektoncd/dashboard)


Current chart version is `0.0.1`

Source code can be found [here](https://github.com/eddycharly/tekton-helm)

## Chart Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../dashboard | dashboard | 0.6.3 |
| file://../pipelines | pipelines | 0.11.5 |
| file://../triggers | triggers | 0.4.0 |

## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| dashboard.enabled | bool | `true` | Enable tekton dashboard |
| pipelines.enabled | bool | `true` | Enable tekton pipelines |
| triggers.enabled | bool | `true` | Enable tekton triggers |
