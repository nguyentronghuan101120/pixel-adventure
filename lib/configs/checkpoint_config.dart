enum CheckpointStatus {
  idle("Checkpoint (Flag Idle)(64x64).png", 10),
  out("Checkpoint (Flag Out) (64x64).png", 26),
  noFlag("Checkpoint (No Flag).png", 1);

  final String value;
  final int animationSequenceAmount;

  const CheckpointStatus(this.value, this.animationSequenceAmount);
}
