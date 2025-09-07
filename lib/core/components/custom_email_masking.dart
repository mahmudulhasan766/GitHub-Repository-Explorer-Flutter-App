String maskEmail(String email, {int visibleChars = 2, String maskChar = '*'}) {
  final parts = email.split('@');
  if (parts.length != 2) {
    return email; // Return original email if invalid format
  }

  final username = parts[0];
  final domain = parts[1];
  
  if (username.length <= visibleChars) {
    return email; // Return the email as-is
  }
  
  final visiblePart = username.substring(0, visibleChars);
  final maskedPart = maskChar * (username.length - visibleChars);

  return '$visiblePart$maskedPart@$domain';
}
