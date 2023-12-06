DOCKER_VERBOSE_ARGS :=
ifneq ($(VERBOSE),)
	DOCKER_VERBOSE_ARGS := --progress=plain
endif


build-sifs: torch.Dockerfile | sifs
	docker build $(DOCKER_VERBOSE_ARGS) -f $< -t torch:lavis-jupyter .
	sudo singularity build sifs/torch.sif docker-daemon://torch:lavis-jupyter

jupyter-notebook:
	singularity run --nv sifs/torch.sif jupyter-lab > jupyter.log 2>&1 &

sifs:
	mkdir -p sifs
