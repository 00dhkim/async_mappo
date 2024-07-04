#!/bin/sh

# Environment and Scenario Settings
env="GridWorld"
scenario="MiniGrid-MultiExploration-v0"

# Agent and Grid Settings
num_agents=2
grid_size=25
num_obstacles=0
local_step_num=1

# Algorithm Settings
algo='ft_apf'
seed_max=3

# Rendering Settings
render_episodes=100
ifi=0.5
max_steps=300
agent_view_size=7

# Execution Settings
n_training_threads=1
n_rollout_threads=1
cuda_devices="0,1,2,3"

# User and WandB Settings
wandb_name="mapping"
user_name="00dhkim"
use_wandb=false
use_render=true
save_gifs=false

# Boolean Flags
use_random_pos=true
use_merge=true
use_merge_plan=true
use_eval=true
astar_cost_mode="normal"
asynch=true

echo "Environment is ${env}"
for seed in `seq ${seed_max}`
do
    echo "Seed is ${seed}"
    exp=new_async_${algo}_grid${grid_size}_stepgoal_${local_step_num}_merge_normal
    CUDA_VISIBLE_DEVICES=${cuda_devices} python3 render/render_gridworld_ft.py\
      --env_name ${env} --algorithm_name ${algo} --experiment_name ${exp} --scenario_name ${scenario} \
      --num_agents ${num_agents} --num_obstacles ${num_obstacles} \
      --seed ${seed} --n_training_threads ${n_training_threads} --n_rollout_threads ${n_rollout_threads} --render_episodes ${render_episodes} \
      --cnn_layers_params '16,3,1,1 32,3,1,1 16,3,1,1' \
      --ifi ${ifi} --max_steps ${max_steps} --grid_size ${grid_size} --local_step_num ${local_step_num} --use_random_pos ${use_random_pos} \
      --agent_view_size ${agent_view_size} --use_merge ${use_merge} --use_merge_plan ${use_merge_plan} --use_eval ${use_eval} \
      --astar_cost_mode ${astar_cost_mode} --wandb_name ${wandb_name} --user_name ${user_name} --asynch ${asynch} \
      --use_wandb ${use_wandb} --use_render ${use_render} --save_gifs ${save_gifs}
done
