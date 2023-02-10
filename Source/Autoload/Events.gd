extends Node

signal camera_shake(value);

signal transition_to(value);

signal player_health_change(value,previous_value);

signal enemy_kill_change(value,previous_value);

signal level_completed;
signal start_timer;
signal timer_finished(value);