package cleanmeat.model;

public class RatingSummary {

    private double avgRating;
    private int totalRating;

    public RatingSummary(double avgRating, int totalRating) {
        this.avgRating = avgRating;
        this.totalRating = totalRating;
    }

    public double getAvgRating() {
        return avgRating;
    }

    public int getTotalRating() {
        return totalRating;
    }
}
