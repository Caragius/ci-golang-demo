FROM golang:1.21.1-alpine3.18 as builder
COPY go.mod go.sum /app/
WORKDIR /app
RUN go mod download
COPY hello /app/hello
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o build/main ./hello

FROM scratch
COPY --from=builder /app/build/main /app
ENTRYPOINT [ "/app" ]