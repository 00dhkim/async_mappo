#!/bin/sh

# Environment and Scenario Settings
env="GridWorld"
scenario="MiniGrid-MultiExploration-v0"

# Agent Settings
num_agents=2
num_obstacles=0

# Algorithm Settings
algo="mappo"
exp="async_global_new_attn_para_disc_single_overlap_normal50"
seed_max=3

# Rendering Settings
render_episodes=100
model_dir="./results/GridWorld/MiniGrid-MultiExploration-v0/mappo/async_global_new_attn_para_disc_single_overlap_normal50/run1/models/"
max_steps=200
agent_view_size=7
local_step_num=1
goal_grid_size=5
cnn_trans_layer="1,3,1,1"
grid_size=25

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
use_complete_reward=true
use_random_pos=true
astar_cost_mode="utility"
use_stack=true
use_recurrent_policy=true
use_global_goal=true
use_overlap_penalty=true
use_eval=true
asynch=true
use_discrect=true

echo "Environment is ${env}"
for seed in `seq ${seed_max}`
do
    echo "Seed is ${seed}:"
    CUDA_VISIBLE_DEVICES=${cuda_devices} python3 render/render_gridworld.py \
      --env_name ${env} --algorithm_name ${algo} --experiment_name ${exp} --scenario_name ${scenario} \
      --num_agents ${num_agents} --num_obstacles ${num_obstacles} \
      --seed ${seed} --n_training_threads ${n_training_threads} --n_rollout_threads ${n_rollout_threads} --render_episodes ${render_episodes} \
      --cnn_layers_params '16,7,2,1 32,5,2,1 16,3,1,1' \
      --model_dir ${model_dir} \
      --max_steps ${max_steps} --use_complete_reward ${use_complete_reward} --agent_view_size ${agent_view_size} --local_step_num ${local_step_num} --use_random_pos ${use_random_pos} \
      --astar_cost_mode ${astar_cost_mode} --goal_grid_size ${goal_grid_size} --cnn_trans_layer ${cnn_trans_layer} \
      --use_stack ${use_stack} --grid_size ${grid_size} --use_recurrent_policy ${use_recurrent_policy} --use_global_goal ${use_global_goal} --use_overlap_penalty ${use_overlap_penalty} \
      --use_eval ${use_eval} --wandb_name ${wandb_name} --user_name ${user_name} --asynch ${asynch} \
      --use_wandb ${use_wandb} --use_discrect ${use_discrect} --use_render ${use_render} --save_gifs ${save_gifs}
done
