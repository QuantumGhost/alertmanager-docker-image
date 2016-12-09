# Alertmanager Alpine

Alpine based docker images for
[alertmanager](https://github.com/prometheus/alertmanager).

## How to use

`docker run quantumghost/alertmanager:0.5.0`

If you would like to use a host directory as `/data`:

`docker run -v /some-dir:/data quantumghost/alertmanager:0.5.0`

Note that you need put `alertmanager.yml` in the mounted directory to
run alertmanager successfully.
