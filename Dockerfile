# Use Go 1.18
FROM golang:1.18 AS builder

WORKDIR /workspace

COPY go.mod go.sum ./
RUN go mod download

COPY cmd/ cmd/
COPY pkg/ pkg/

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /techvault ./cmd/techvault

# Use distroless
FROM gcr.io/distroless/base-debian10

COPY --from=builder /techvault /techvault

ENTRYPOINT ["/techvault"]
CMD ["random"]

