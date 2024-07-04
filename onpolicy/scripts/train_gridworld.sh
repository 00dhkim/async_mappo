#!/bin/sh

# Environment and Scenario Settings
env="GridWorld"
scenario="MiniGrid-MultiExploration-v0"

# Agent and Grid Settings
num_agents=2
num_obstacles=0
grid_size=25
goal_grid_size=5
local_step_num=5

# Algorithm Settings
algo="mappo"
exp="async_global_new_attn_para_disc_single_overlap_normal50"
seed_max=1

# Rendering Settings
cnn_trans_layer="1,3,1,1"
agent_view_size=7
max_steps=150

# Execution Settings
n_training_threads=1
n_rollout_threads=50
num_mini_batch=1
num_env_steps=80000000
ppo_epoch=3
gain=0.01
lr=5e-4
critic_lr=5e-4
cuda_devices="0,1,2,3"

# Logging Settings
log_interval=1
wandb_name="mapping"
user_name="00dhkim"
use_wandb=false

# Boolean Flags
use_recurrent_policy=true
use_discrect=true
asynch=true
use_random_pos=true
astar_cost_mode="normal"
use_global_goal=true
use_stack=true
use_overlap_penalty=true
use_complete_reward=true

echo "Environment is ${env}, scenario is ${scenario}, algorithm is ${algo}, experiment is ${exp}, max seed is ${seed_max}"
for seed in `seq ${seed_max}`;
do
    echo "Seed is ${seed}:"
    CUDA_VISIBLE_DEVICES=${cuda_devices} python3 train/train_gridworld.py \
    --env_name ${env} --algorithm_name ${algo} --experiment_name ${exp} --scenario_name ${scenario} \
    --num_agents ${num_agents} --num_obstacles ${num_obstacles} \
    --cnn_layers_params '16,7,2,1 32,5,2,1 16,3,1,1' --cnn_trans_layer ${cnn_trans_layer} \
    --use_recurrent_policy ${use_recurrent_policy} --use_discrect ${use_discrect} --asynch ${asynch} \
    --max_steps ${max_steps} --agent_view_size ${agent_view_size} --local_step_num ${local_step_num} --use_random_pos ${use_random_pos} \
    --astar_cost_mode ${astar_cost_mode} --grid_size ${grid_size} --goal_grid_size ${goal_grid_size} --use_global_goal ${use_global_goal} \
    --use_stack ${use_stack} --use_overlap_penalty ${use_overlap_penalty} --use_complete_reward ${use_complete_reward} \
    --log_interval ${log_interval} --wandb_name ${wandb_name} --user_name ${user_name} \
    --hidden_size 64 --seed ${seed} --n_training_threads ${n_training_threads} \
    --n_rollout_threads ${n_rollout_threads} --num_mini_batch ${num_mini_batch} --num_env_steps ${num_env_steps} --ppo_epoch ${ppo_epoch} --gain ${gain} \
    --lr ${lr} --critic_lr ${critic_lr}  \
    --use_wandb ${use_wandb}
done
