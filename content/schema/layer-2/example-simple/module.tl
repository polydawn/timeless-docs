{
    "imports": {
        "base": "catalog:early.polydawn.io/monolith/busybash:v1:linux-amd64"
    },
    "steps": {
        "step-name": {
            "operation": {
                "inputs": {
                    "/": "base"
                },
                "action": {
                    "exec": [
                        "/bin/bash", "-c",
                        "mkdir out && echo hello | tee /task/out/file"
                    ]
                },
                "outputs": {
                    "out": "/task/out"
                }
            }
        }
    },
    "exports": {
        "export-label": "step-name.out"
    }
}
