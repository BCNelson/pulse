package main

import "testing"

func TestEnvOrDefault(t *testing.T) {
	t.Setenv("PULSE_TEST_VALUE", "configured")

	if got := envOrDefault("PULSE_TEST_VALUE", "fallback"); got != "configured" {
		t.Fatalf("expected configured value, got %q", got)
	}

	if got := envOrDefault("PULSE_MISSING_VALUE", "fallback"); got != "fallback" {
		t.Fatalf("expected fallback value, got %q", got)
	}
}
