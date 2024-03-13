import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :web, Web.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "vdpQqLxOSFWUQ0cxnSClcodqtTvWtfBClWfJavRNPRtfx9N/COU4uzmyutozGmd/",
  server: false
