build: 
	docker build -f torch.Dockerfile -t torch:lavis-jupyter .
	sudo singularity build torch.sif docker-daemon://torch:lavis-jupyter
