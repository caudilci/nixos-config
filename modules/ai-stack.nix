{ config, pkgs, ... }: {
  # Integration for the noamsto/nix-amd-ai flake logic
  # Note: The 'hardware.amd-npu' options are provided by the imported module in flake.nix
  hardware.amd-npu = {
    enable = true;
    enableNPU = true;          # Set to false if only using GPU’s ROCm
    enableFastFlowLM = true;   # AI LLM inference on NPU
    enableLemonade = true;     # The local AI server
    lemonade.user = "cc";      # Your user defined in core.nix
    enableROCm = true;         # GPU acceleration
    enableVulkan = true;       # Vulkan acceleration
  };

  # Specific high-level AI packages from your prev config
  services.ollama = {
    enable = true;
    package = pkgs.ollama-rocm;
    host = "0.0.0.0";
  };

  environment.systemPackages = with pkgs; [
    rocmPackages.clr.icd
    ollama-rocm
    open-webui
  ];
}